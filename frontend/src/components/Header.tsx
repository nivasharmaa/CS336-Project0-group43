'use client';
import { Box, Flex, Heading, Text } from '@chakra-ui/react';

export default function Header() {
  return (
    <Box
      as="header"
      bgGradient="linear(to-r, teal.500, blue.600)"
      color="white"
      py={4}
      px={{ base: 4, md: 8 }}
      boxShadow="lg"
    >
      <Flex maxW="6xl" mx="auto" align="center" justify="space-between">
        <Heading as="h1" size="lg" letterSpacing="tight">
          The Query Pilot
        </Heading>
        <Text fontSize={{ base: 'sm', md: 'md' }} color="whiteAlpha.800">
          Navigate your data with natural language
        </Text>
      </Flex>
    </Box>
  );
}
